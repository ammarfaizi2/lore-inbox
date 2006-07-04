Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWGDTQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWGDTQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWGDTQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:16:38 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:20688 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932344AbWGDTQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:16:38 -0400
Date: Tue, 4 Jul 2006 21:16:36 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060704191636.GU3305@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704010240.GD6317@thunk.org>
User-Agent: Mutt/1.5.11-2006-06-13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
... wow ... thank you for all the awareness training. I have now a much
better idea what is happening now. And who knows, maybe I am going to submit
some patches when ext4 isn't already released in three months. I didn't
knew about the checksum capability of newer drives. I only new about the
DMA crc. But it is definitively the right way to go.

        Thomas
