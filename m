Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUJLO40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUJLO40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUJLOyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:54:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264639AbUJLOw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:52:28 -0400
Date: Tue, 12 Oct 2004 10:49:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephan <support@bbi.co.bw>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Problem compiling linux-2.6.8.1......
In-Reply-To: <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN>
Message-ID: <Pine.LNX.4.61.0410121048110.3470@chaos.analogic.com>
References: <006901c4b05a$3dddd570$0200060a@STEPHANFCN56VN>
 <20041012141123.GA18579@stusta.de> <001401c4b068$7cb74750$0200060a@STEPHANFCN56VN>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Stephan wrote:

> I've tried to recompile the kernel and watched very carefully for anything 
> out off the ordinary but could not find anything that might relate to an 
> error message.
>
> Is there anything specific I should keep any eye out for?
>
> Kind Regards
> Steph

Do:

script

make clean
make

exit

Whatever happened is now in file typescript.



Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

