Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUGNR25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUGNR25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUGNR25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:28:57 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:26601 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S265106AbUGNR2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:28:55 -0400
To: lkml <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: sleep (rather, wake) of death on Powerbook G3 Lombard
Organization: Lehrstuhl fuer vergleichende Astrozoologie
X-Mahlzeit: Das ist per Saldo Gemuetlichkeit
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 14 Jul 2004 19:28:50 +0200
Message-ID: <hhzn62ijl9.fsf@theorie.physik.uni-muenchen.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting reproducible freezes out of my Powerbook G3 Lombard if and
only if the OHCI USB host controller is enabled and the machine is put
to sleep.  On wakeup, the "breathing" green light goes off, but the
screen stays blank and all can be done is to reboot using
Ctrl-Command-Power.  If the module is not loaded, the system wakes up
just fine.

Regards, Jens.

-- 
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!
