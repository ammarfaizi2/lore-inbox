Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVJLOMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVJLOMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVJLOMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:12:19 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:27097 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S964788AbVJLOMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:12:19 -0400
Date: Wed, 12 Oct 2005 16:12:18 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: modalias entries for ccw devices
Message-ID: <20051012141218.GA4039@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

The ccw devices currently don't have a modalias spec in sysfs. This
makes it impossible to ask udev for loading the modules.

Are there any patches pending?

Bastian

-- 
There is a multi-legged creature crawling on your shoulder.
		-- Spock, "A Taste of Armageddon", stardate 3193.9
