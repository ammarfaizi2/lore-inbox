Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUBRP0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 10:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267510AbUBRP0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 10:26:06 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:63435 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267507AbUBRP0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 10:26:04 -0500
Message-ID: <4033841A.6020802@inp-net.eu.org>
Date: Wed, 18 Feb 2004 16:26:18 +0100
From: Raphael Rigo <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New do_mremap vulnerabitily.
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since it seems nobody posted it yet (at least I hope so) :

http://www.isec.pl/vulnerabilities/isec-0014-mremap-unmap.txt

It is a local root exploit.

Raphaël Rigo
