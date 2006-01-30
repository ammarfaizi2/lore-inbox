Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWA3Qtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWA3Qtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWA3Qtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:49:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29587 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964773AbWA3Qtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:49:50 -0500
In-Reply-To: <200601301621.24051.a1426z@gawab.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF619E8613.030E66B6-ON88257106.005BF570-88257106.005C7272@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Mon, 30 Jan 2006 08:49:45 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/30/2006 11:49:42,
	Serialize complete at 01/30/2006 11:49:42
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > With todays generically mass-produced 64bit archs, what's not to care
>> > about a cost-effective system that provides direct mapped access into 

>> > linear address space?
>>
>> I don't know; I'm sure it's complicated.
>
>Why would you think that the shortest path between two points is 
complicated, 

I can see that my statement could be read a different way from what I 
meant.  I meant I'm sure that the reason people don't care about single 
level storage is complicated.  (Ergo I haven't tried, so far, to argue for 
or against it but just to point out some history).

