Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVAEIh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVAEIh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 03:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAEIh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 03:37:57 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:48081 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262294AbVAEIhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 03:37:45 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 TCP troubles
Date: Wed, 05 Jan 2005 08:13:17 GMT
Message-ID: <05081I514@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the senario:
the Linux machine is writting through libsmbclient
to an OSX machine running Samba

Switching the Linux machine from 2.6.8 to 2.6.10 made the network speed
drop drastically: 20 seconds with 2.6.8, 800 seconds with 2.6.10

