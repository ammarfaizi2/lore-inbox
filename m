Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVJLOhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVJLOhG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVJLOhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:37:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5592 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964796AbVJLOhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:37:05 -0400
Subject: Re: modalias entries for ccw devices
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Bastian Blank <bastian@waldi.eu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051012141218.GA4039@wavehammer.waldi.eu.org>
References: <20051012141218.GA4039@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 16:36:58 +0200
Message-Id: <1129127818.32420.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 16:12 +0200, Bastian Blank wrote:

Hi Bastian,

> The ccw devices currently don't have a modalias spec in sysfs. This
> makes it impossible to ask udev for loading the modules.

Hmm, never heard of modalias. Arnd has done the module loading for ccw
devices. That must be something rather new.

> Are there any patches pending?

No, but as far as I can tell after glancing at the modalias
implementation in usb this would make sense for ccw as well.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


