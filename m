Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136890AbREKLya>; Fri, 11 May 2001 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136996AbREKLyL>; Fri, 11 May 2001 07:54:11 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:61181
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S136890AbREKLyI>; Fri, 11 May 2001 07:54:08 -0400
Subject: Re: monitor file writes
From: Xavier Bestel <xavier.bestel@free.fr>
To: Dennis Bjorklund <db@zigo.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
In-Reply-To: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 11 May 2001 13:51:26 +0200
Message-Id: <989581889.19092.1.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08 May 2001 06:27:52 +0200, Dennis Bjorklund a écrit :
> Is there a way in linux to montior file writes?
> 
> I have something that is writing to the disk every 5:th second (approx.)

probably kupdate ... look for noflushd on freshmeat.net and read the
docs.

Xav

