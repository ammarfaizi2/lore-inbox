Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWADROg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWADROg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWADROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:14:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:53194 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932066AbWADROf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:14:35 -0500
Date: Wed, 4 Jan 2006 11:07:51 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: linux-kernel@vger.kernel.org
cc: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: platform_device_add_resources doesn't request the resources?
Message-ID: <Pine.LNX.4.44.0601041104560.32358-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason that platform_device_add_resources doesn't process the 
resources that are passed to it like platform_device_add does?

- kumar

