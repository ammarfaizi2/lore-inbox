Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUBRFKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 00:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUBRFKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 00:10:51 -0500
Received: from quantumcode.net ([66.45.229.144]:11781 "EHLO quantumcode.net")
	by vger.kernel.org with ESMTP id S263661AbUBRFKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 00:10:44 -0500
Subject: USB access via KVM broken in 2.6[0-3]
From: "Hayden A. James" <hjames@quantumcode.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077081034.6813.22.camel@haydend.quantumcode.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 18 Feb 2004 00:10:34 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know what happened between 2.4.x and the latest 2.6.x release
but USB access to my keyboard and mouse from my USB KVM (Ioport
miniview) does NOT work at all for any of the devices.  The devices work
normally in 2.6 without having the kvm connected, however.  Is this an
already known issue?


-- 
Hayden A. James
Computer Engineer
http://www.quantumcode.net/

A policeman pulls Werner Heisenberg over on the autobahn for speeding.
Policeman: Sir, do you know how fast you were going?
Heisenberg: No, but I know exactly where I am.


