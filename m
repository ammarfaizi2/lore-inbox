Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWBMRO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWBMRO3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 12:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWBMRO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 12:14:29 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17321 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932269AbWBMRO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 12:14:28 -0500
Date: Mon, 13 Feb 2006 18:14:27 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: seanlkml@sympatico.ca, sam@vilain.net, peter.read@gmail.com,
       matthias.andree@gmx.de, lkml@dervishd.net, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060213.171329.3029.atrey@ucw.cz>
References: <43EC88B8.nailISDH1Q8XR@burner> <43EFC1FF.7030103@vilain.net> <43F097AE.nailKUSK1MJ9O@burner> <BAYC1-PASMTP10B5F649DEDADD145E56BDAE070@CEZ.ICE> <20060213095038.03247484.seanlkml@sympatico.ca> <43F0A771.nailKUS131LLIA@burner> <mj+md-20060213.160108.13290.atrey@ucw.cz> <43F0B32D.nailKUS1E3S8I3@burner> <mj+md-20060213.164948.25807.atrey@ucw.cz> <43F0BA53.nailMDD11T4U8@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0BA53.nailMDD11T4U8@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Let me write a final remark:
> 
> cdrecord currently has no known Linux specific bug.
> 
> Let us comtinue to talk after the Linux kernel bugs that
> prevent cdrecord from working have been fixed.

OK. And in the meantime you can remove the silly warnings about
device names being unsupported.

					MM
