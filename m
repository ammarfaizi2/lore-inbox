Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWGDL1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWGDL1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWGDL1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:27:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3038 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751289AbWGDL1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:27:04 -0400
Date: Tue, 4 Jul 2006 12:26:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>,
       viro@zeniv.linux.org.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] partitions: let partitions inherit policy from disk
Message-ID: <20060704112658.GF29920@ftp.linux.org.uk>
References: <44A90B9A.5080805@de.ibm.com> <20060704080215.GS4038@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704080215.GS4038@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Makes sense to me, however I'll let Al ack this for inclusion. Al?

ACK, looks sane.
