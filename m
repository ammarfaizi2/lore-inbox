Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290662AbSAYM63>; Fri, 25 Jan 2002 07:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290667AbSAYM6T>; Fri, 25 Jan 2002 07:58:19 -0500
Received: from ns.tasking.nl ([195.193.207.2]:60173 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S290662AbSAYM6G>;
	Fri, 25 Jan 2002 07:58:06 -0500
Date: Fri, 25 Jan 2002 13:55:45 +0100
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: restoring hard linked files from zisofs/iso9660 w. RR
Message-ID: <20020125135545.A28897@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't seem to work due to inode number differences. Is
this a fundamental problem or can it be solved somehow, e.g.
by an attribute which refers to a sort of "original" inode
number?

or by a more advanced inode number synthesis in fs/isofs?

-- 
Frank
