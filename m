Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWEXUTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEXUTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEXUTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:19:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:48223 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932308AbWEXUTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:19:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PLIFx28456L98cH6ArQ/QtiG4RlDi7ZC1HzNqKx2YKq5bZzMVOMYVJIEJUnC2Csip02cqcnGP+sWjL+R9cd12Pqzay7/cIwGbSSzKX2TgkRNlQOYTAUg/BKEotmT1H4HQPQrzA7QqtzqtbPGjmammsogXMZHZmm3yuPWtZ/viak=
Message-ID: <3faf05680605241319y3b0f332v45922fc34ea0bf8@mail.gmail.com>
Date: Thu, 25 May 2006 01:49:32 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: "vamsi krishna" <vamsi.krishnak@gmail.com>, linux-kernel@vger.kernel.org,
       dan@debian.org
Subject: Re: Program to convert core file to executable.
In-Reply-To: <20060524200837.GA5679@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
	 <20060524173821.GA1292@nevyn.them.org>
	 <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
	 <20060524200837.GA5679@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,


> You might want to take a look at GDB's generate-core-file command.
>

Does gdb take care (loading) of core files generated on machine which
support ASLR (Address  Space Layout Randomization)? , currently ASLR
is being shipped as exec-shield in redhat

Thanks,
Vamsi
