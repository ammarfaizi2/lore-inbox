Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbTJYX15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 19:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTJYX15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 19:27:57 -0400
Received: from 217-124-6-235.dialup.nuria.telefonica-data.net ([217.124.6.235]:10117
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S263110AbTJYX14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 19:27:56 -0400
Date: Sun, 26 Oct 2003 01:27:55 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason
Message-ID: <20031025232755.GA15889@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3F9AF1AB.3000304@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9AF1AB.3000304@planet.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 25 October 2003, at 23:56:59 +0200,
Stef van der Made wrote:

> I'm not sure if I should log a bug and what the problem area could be.
> 
You should provide more information before opening any bug, for example,
exact kernel version used, filesystems mounted and their types (as well
as mount options used). In older kernel 2.4.x versions there were
similar problems to the one you describe, related to (if I recall
correctly) writing the journal contents back to disk after heavy IO load.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test8-mm1)
