Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRC0VQ1>; Tue, 27 Mar 2001 16:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131589AbRC0VQR>; Tue, 27 Mar 2001 16:16:17 -0500
Received: from fireball.blast.net ([207.162.131.33]:19466 "EHLO
	fireball.blast.net") by vger.kernel.org with ESMTP
	id <S131578AbRC0VQL>; Tue, 27 Mar 2001 16:16:11 -0500
Message-ID: <3AC102EF.A86D484E@voicenet.com>
Date: Tue, 27 Mar 2001 16:15:27 -0500
From: Uncle George <gatgul@voicenet.com>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-7.0 alpha)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: slow latencies on IDE disk drives( controller? )
In-Reply-To: <Pine.LNX.4.10.10103270904490.16125-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fix is a lot simpler. It has to be placed in release notes that the
generic ide can cause the sound device to distort the sound stream. 
Would that be a fair statement ?


Andre Hedrick wrote:
> 
>
> 
> This is your fix....
> 
> Andre Hedrick
>
