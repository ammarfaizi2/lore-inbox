Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbTBXHvg>; Mon, 24 Feb 2003 02:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTBXHvg>; Mon, 24 Feb 2003 02:51:36 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:47310 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S264813AbTBXHve>; Mon, 24 Feb 2003 02:51:34 -0500
Date: Mon, 24 Feb 2003 09:00:28 +0100
From: jarausch@igpm.rwth-aachen.de
Subject: 2.4.21-pre4(-ac4) ppp modules don't build
To: linux-kernel@vger.kernel.org
Reply-to: jarausch@igpm.rwth-aachen.de
Message-id: <200302240800.JAA13853@numa1.igpm.rwth-aachen.de>
MIME-version: 1.0
Content-type: TEXT/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have no problems building a kernel with the ppp-modules
builtin from the beginning.
But when I try to include these as modules only I
get lots of undefined symbols during modules_install.

Is this known and is there a work-around?

Many thanks for a hint,

Helmut Jarausch

Lehrstuhl fuer Numerische Mathematik
Aachen University
D 52056 Aachen, Germany


