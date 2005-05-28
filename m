Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVE1MaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVE1MaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 08:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVE1MaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 08:30:05 -0400
Received: from main.gmane.org ([80.91.229.2]:17069 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262717AbVE1MaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 08:30:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: PATCH: "Ok" -> "OK" in messages
Date: Sat, 28 May 2005 14:29:18 +0200
Message-ID: <yw1xoeavmt41.fsf@ford.inprovide.com>
References: <42985251.6030006@cpan.org> <007001c56387$235672d0$2800000a@pc365dualp2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:f4wJRpOtdiFcTOat2Iyzg+EfTKI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<cutaway@bellsouth.net> writes:

> "Sean M. Burke" <sburke@cpan.org> wrote:
>
>> The English interjection "OK" is misspelled as "Ok" in a dozen
>> messages in the Linux kernel.  The following patch corrects
>> those typos from "Ok" to "OK".  It affects no comments or
>> symbol-names -- and it stops me wanting to gnaw my fingers off every
>> time I see "Ok, booting the kernel."!
>
> That's not the most annoying IMO - see how many instances of something like
> this you'll sprinkled around:
>
> printk("The PukeMaster is %sabled.\n", SomeFlag ? "dis" : "en");
>
> If a NLS translator isn't a C programmer, they'll screw it up frequently.

That's true, but the Linux kernel isn't subject to NLS translations.

-- 
Måns Rullgård
mru@inprovide.com

