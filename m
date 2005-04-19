Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVDSMQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVDSMQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVDSMQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:16:32 -0400
Received: from ns.schottelius.org ([213.146.113.242]:6673 "HELO
	ei.schottelius.org") by vger.kernel.org with SMTP id S261467AbVDSMQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:16:29 -0400
Date: Tue, 19 Apr 2005 14:15:30 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Subject: /proc/cpuinfo format - arch dependent!
Message-ID: <20050419121530.GB23282@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.11.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When I wrote schwanz3(*) for fun, I noticed /proc/cpuinfo
varies very much on different architectures.

Is it possible to make it look more identical (as far as the different
archs allow it)?

So that one at least can count the cpus on every system the same way.

If so, who would the one I should contact and who would accept / verify
a patch doing that?

Greetings,

Nico

-- 
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org
