Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317016AbSFKMQV>; Tue, 11 Jun 2002 08:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSFKMQU>; Tue, 11 Jun 2002 08:16:20 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:10462 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317016AbSFKMQS>; Tue, 11 Jun 2002 08:16:18 -0400
Date: Tue, 11 Jun 2002 06:16:10 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Russell King <rmk@arm.linux.org.uk>
cc: Thunder from the hill <thunder@ngforever.de>,
        Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.21: kbuild changes broke filenames with commas
In-Reply-To: <20020611122144.A3665@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0206110611590.24261-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue 11 Jun 2002 Russell King wrote:
> On Tue Jun 11 2002 at 05:11:13AM -0600 Thunder from the hill wrote:
> > Think big! Think about __future__.
> 
> The path to overdesign and excessive featurebloat.

Well the question is then how will things look without commas? I suppose 
if we have very complex things and prevent using commas whereas I don't 
assert that we do for text but this is just a bloat example it's good to 
have things like commas allowed even though we are in case we won't allow 
them there talking about file names.

If we allow commas all over the filesystem and likewise say that there is 
nothing to mention about it why should we refuse them for kbuild 
especially since there is a parallel system which allows commas?

Regards
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

