Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWILJXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWILJXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWILJXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:23:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:3917 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965158AbWILJXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:23:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WV6lACEdG5qkpx66xOzyXOFU8CGRr8zMreIw6CW3t2PRg2WL+O9FPlayVzfoB0+fB1rn1hdGFSx0w/RzWTdA59sHVxLY6SL3LgE0Xun2zNV2RvYYaxzVdsVUTFLTjCK88oIrBYSYU4vomRY+aQuLy7Lewl6GJJjAeWO4Hdd5oRI=
Message-ID: <acd2a5930609120223m2776ed24o47e3b3c1e595ac5e@mail.gmail.com>
Date: Tue, 12 Sep 2006 13:23:08 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [linux-pm] cpufreq terminally broken [was Re: community PM requirements/issues and PowerOP]
Cc: "Mark Gross" <mgross@linux.intel.com>,
       "Preece Scott-PREECE" <scott.preece@motorola.com>,
       "pm list" <linux-pm@lists.osdl.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060912091619.GA19482@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060911082025.GD1898@elf.ucw.cz>
	 <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com>
	 <20060912083328.GA19197@elf.ucw.cz>
	 <acd2a5930609120210w7ee5a156s5fa5bbc59aeabad8@mail.gmail.com>
	 <20060912091619.GA19482@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Pavel Machek <pavel@ucw.cz> wrote:
> > who talks about user <-> kernel interface level changes at the moment?!
> Eugeny?

Well, as far as I understood, both parties are ready to talk about
_kernel_ interface at the moment. Let's try to look at it from this
very point of view.
Eugeny, please correct me if my understanding is wrong.

Vitaly
