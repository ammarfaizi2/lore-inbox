Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSA1VPw>; Mon, 28 Jan 2002 16:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285482AbSA1VPm>; Mon, 28 Jan 2002 16:15:42 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:51872 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S285369AbSA1VPY>; Mon, 28 Jan 2002 16:15:24 -0500
Date: Mon, 28 Jan 2002 16:31:59 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Diego Calleja <grundig@teleline.es>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <20020128204135Z289398-13997+11239@vger.kernel.org>
Message-ID: <Pine.LNX.4.40.0201281627040.13771-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 xxx -1, Diego Calleja wrote:

> X 4.1.0 (debian woody release)

I was going to pipe up and say that I think 4.2.0 fixed the problem.  But
today running a 2.4.17 kernel, and X 4.2.0, I flopped out of X and to look
at e-mail on a normal text console (132x60) to find the bottom of my '7's
eaten away.

This font corruption has seemed to have gotten better over time (orginally
I saw thins like yellow blinking question marks on red background
scattered about my screen a year ago), 2.4.17 and 4.2.0 seem to have the
problem at an all time low.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

