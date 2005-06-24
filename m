Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVFXOvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVFXOvF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 10:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVFXOvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 10:51:05 -0400
Received: from dvhart.com ([64.146.134.43]:12978 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262905AbVFXOue convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 10:50:34 -0400
Date: Fri, 24 Jun 2005 07:50:32 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: linux-kernel@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       =?ISO-8859-1?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
Subject: Re: Script to help users to report a BUG
Message-ID: <9500000.1119624632@[10.10.2.4]>
In-Reply-To: <4d8e3fd3050624050955aac41b@mail.gmail.com>
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com> <9a87484905062311246243774e@mail.gmail.com> <20050623120647.2a5783d1.rdunlap@xenotime.net> <9a87484905062312131e5f6b05@mail.gmail.com> <42BAF608.6080802@trex.wsi.edu.pl> <4d8e3fd305062313032c9789e8@mail.gmail.com> <42BAFE3E.2050407@trex.wsi.edu.pl> <4d8e3fd305062400524f0ad358@mail.gmail.com> <42BBC189.5050805@trex.wsi.edu.pl> <4d8e3fd3050624032264081edf@mail.gmail.com> <4d8e3fd3050624050955aac41b@mail.gmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote (on Friday, June 24, 2005 14:09:18 +0200):

> 2005/6/24, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>:
>> 2005/6/24, Micha³ Piotrowski <piotrowskim@trex.wsi.edu.pl>:
>> > Hi,
>> > 
>> > Here is the latest version:
>> > http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a10.tar.bz2
>> > 
>> > Changelog:
>> > - Paolo's text input method - txt_read() (old is txt_read_ed() it's only
>> > a test ;))
>> > - now only root [uid=0] may run script
>> > - small optimalisations (point 8 etc.)
>> > 
>> > Todo:
>> > - more email clients
>> > - bugzilla automatic posts?
> 
> May be Martin can help us ?
> automatic post to bugzilla would be a great things!

Not really keen on that ... when the script goes wrong, it'll potentially
file bugs at a huge rate. Plus you'd have to fill out fields, etc properly.

M.

