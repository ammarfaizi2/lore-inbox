Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270462AbRHNMnt>; Tue, 14 Aug 2001 08:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270469AbRHNMnj>; Tue, 14 Aug 2001 08:43:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S270462AbRHNMnY>; Tue, 14 Aug 2001 08:43:24 -0400
Message-ID: <3B791CA8.29E97814@idb.hist.no>
Date: Tue, 14 Aug 2001 14:42:16 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre8 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Is there something that can be done against this ???
In-Reply-To: <NOEJJDACGOHCKNCOGFOMKENKDCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
> > The question is not : "is this script dangerous ?",
> > but "are you ready to blindly execute a shell script
> > (or any program) that you receive in your  mail ?".
> 
>         Sure, as a user created solely for that purpose, it should be entirely
> safe.

It definitely ought to be safe.  But don't run any script people mail
you in a test account - you'll be sorry when they exploit a bug in
your kernel or perhaps one of your trusted daemons...

Helge Hafting
