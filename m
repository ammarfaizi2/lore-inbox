Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288928AbSAIGsX>; Wed, 9 Jan 2002 01:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288926AbSAIGsN>; Wed, 9 Jan 2002 01:48:13 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:53479 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S288919AbSAIGsE>;
	Wed, 9 Jan 2002 01:48:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Brian <hiryuu@envisiongames.net>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Date: Tue, 8 Jan 2002 22:48:03 -0800
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain> <0GPN00CMLRC7U8@mtaout45-01.icomcast.net> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OCWq-0000mh-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 8, 2002 22:45, Ryan Cumming wrote:
> In the charts in the original message, he's not increasing the number of
> jobs, but the number of concurrent 'make -j8's. Two makes should really
> finish in half the time one make does. I don't see any problem with the
> results.
Er, I meant finish in twice the time one make does... really... ;)

-Ryan
