Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbUEYTuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbUEYTuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUEYTrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:47:37 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:39331 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265087AbUEYTqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:46:39 -0400
Subject: Re: System clock running too fast
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <TazForEver@free.fr>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200405251939.47165.mbuesch@freenet.de>
References: <200405251939.47165.mbuesch@freenet.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1085514395.11860.8.camel@athlon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 25 May 2004 21:46:36 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar, 25/05/2004 à 19:39 +0200, Michael Buesch a écrit :
> Hi,
> 
> I've got the problem with my server, that the system-clock
> is running really fast. It's running over one second too
> fast in one hour (aproximately).

you should adjust it with adjtimex (there's a debian package)

-- 
Benoît Dejean
JID: TazForEver@jabber.org
http://gdesklets.gnomedesktop.org
http://www.paulla.asso.fr


