Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCEMnO>; Tue, 5 Mar 2002 07:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293074AbSCEMnD>; Tue, 5 Mar 2002 07:43:03 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:60871 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S293064AbSCEMmu>; Tue, 5 Mar 2002 07:42:50 -0500
Date: Tue, 5 Mar 2002 13:42:46 +0100 (MET)
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-X-Sender: sithglan@faui02.informatik.uni-erlangen.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.18: Problems with IP: kernel level autoconfiguration
Message-ID: <Pine.GSO.4.44.0203051338470.6405-100000@faui02.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My 2.4.18 Kernel does not try to receive dhcp.

CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y

Is there anything else out here which I have to enable in order to get things
work? Is there any further Documentation in the tree?

Greetings,

		Thomas

