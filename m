Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUHISJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUHISJp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUHISJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:09:44 -0400
Received: from server02.akkaya.de ([213.168.83.203]:23389 "EHLO
	server02.akkaya.de") by vger.kernel.org with ESMTP id S264953AbUHISJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:09:41 -0400
From: Juergen Pabel <jpabel@akkaya.de>
Organization: Akkaya Consulting GmbH
To: Eric Lammerts <eric@lammerts.org>
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
Date: Mon, 9 Aug 2004 20:12:34 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408080413.29905.jpabel@akkaya.de> <200408081430.59840.jpabel@akkaya.de> <Pine.LNX.4.58.0408081204270.7223@vivaldi.madbase.net>
In-Reply-To: <Pine.LNX.4.58.0408081204270.7223@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408092012.34255.jpabel@akkaya.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sure you can do something similar for dmcrypt.

yes, there is....but just like you dislike my way, I disliked the approach you
mentioned (which is actually, how I've set up rootfs encryption
in the past here at work - due to the lack of an alternative approach).

i just find my approach more suitable (from a philosophical design point of
view) - as it provides a generic way for submitting sensitive data
during/before the boot phase to the kernel.

jp

