Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265318AbRF0MNt>; Wed, 27 Jun 2001 08:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbRF0MNa>; Wed, 27 Jun 2001 08:13:30 -0400
Received: from osiris.speedkom.net ([213.182.0.1]:19332 "EHLO
	mailin1.mx.speedkom.net") by vger.kernel.org with ESMTP
	id <S265314AbRF0MNW>; Wed, 27 Jun 2001 08:13:22 -0400
Date: Wed, 27 Jun 2001 14:13:19 +0200
From: "Andreas S. Kerber" <ask@ag-trek.de>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.5: networking problems with bintec router
Message-ID: <20010627141319.A721@osiris.speedkom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

! This problem occurs, nomatter wether ECN is enabled or disabled !:

Since upgrading to Linux 2.4.5 (ECN disabled!) I'm unable to connect to any
hosts which are located behind a Bintec Brick router (the brick performs
port forwarding).
When I'm trying to connect from a Linux 2.2 machine, I have no problems
at all.

Are there any known networking problems between Linux 2.4 and
Bintec routers?
