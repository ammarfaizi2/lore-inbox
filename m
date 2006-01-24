Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWAXRMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWAXRMx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 12:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWAXRMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 12:12:52 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:44989 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030447AbWAXRMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 12:12:52 -0500
Date: Tue, 24 Jan 2006 18:12:49 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: Why is /sound not in /drivers/media?
Message-ID: <20060124171249.GA8406@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g3ee68c4a-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I just asked myself why the /sound tree is not within /drivers/media right
besides /drivers/media/video. Wouldn't that make sense? Could the movement be
done on OSS removal?

I didn't find any info on that. Maybe someone might help me understand...

Regards,
Marc
