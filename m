Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUCFSqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 13:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUCFSqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 13:46:30 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:14507
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261700AbUCFSqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 13:46:30 -0500
Message-ID: <404A1C71.3010507@redhat.com>
Date: Sat, 06 Mar 2004 10:46:09 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040305
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@navi.cx
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen>
In-Reply-To: <1078508281.3065.33.camel@linux.littlegreen>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Hearn wrote:

> When mapping a nobits PT_LOAD segment with a memsize > filesize,

Show an example of what the file looks like.  Just the ELF program
header (readelf -l output).

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
