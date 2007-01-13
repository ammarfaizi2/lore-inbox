Return-Path: <linux-kernel-owner+w=401wt.eu-S1161252AbXAMDok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161252AbXAMDok (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbXAMDok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:44:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:13118 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161252AbXAMDoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:44:39 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NIkShwaMCSxIv/gM6Hi/oDlrs1W1qsEsswGstE63lZvWhqWBJzJ36uJvDzLKD8zI0ZwjKSnWxhZT8Xg5nv0vpsZO++MnSVmm0Wj/BXA5c/ALnreAQRLltBifkj8b5+MW/XcL+hxL4lTAtaXkmol4FFYw9vN/xx98CjNnNA8Mpmk=
Message-ID: <b6a2187b0701121944j702ba941s1cc0583e476ceb6a@mail.gmail.com>
Date: Sat, 13 Jan 2007 11:44:36 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Linux v2.6.20-rc5
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <b6a2187b0701121936t3175d7a1i21eb6fa1f72cac1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	 <20070112142645.29a7ebe3.akpm@osdl.org>
	 <b6a2187b0701121936t3175d7a1i21eb6fa1f72cac1d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/07, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> On 1/13/07, Andrew Morton <akpm@osdl.org> wrote:
> > On Fri, 12 Jan 2007 14:27:48 -0500 (EST)
> > Linus Torvalds <torvalds@osdl.org> wrote:
>
>   CC [M]  drivers/kvm/vmx.o
> {standard input}: Assembler messages:
> {standard input}:3257: Error: bad register name `%sil'
> make[2]: *** [drivers/kvm/vmx.o] Error 1
> make[1]: *** [drivers/kvm] Error 2
> make: *** [drivers] Error 2
>
> Am I missing something or this is a real problem?
> Applied 2.6.20-rc5-mm-fixes and got this problem.
> Using gcc version 3.4.5, binutils-2.17.50.0.8

Same problem with vanilla linux-2.6.20-rc5.

Thanks,
Jeff.
