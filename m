Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313832AbSDPTaO>; Tue, 16 Apr 2002 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313833AbSDPTaN>; Tue, 16 Apr 2002 15:30:13 -0400
Received: from [194.46.8.33] ([194.46.8.33]:42248 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S313832AbSDPTaM>;
	Tue, 16 Apr 2002 15:30:12 -0400
Date: Tue, 16 Apr 2002 19:26:44 +0100
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Translucent overmounts
Message-ID: <20020416182644.GA7427@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be useful to take an RO device and overmount (or vice
versa) a ramdisk for temporary data. Say a /etc on CDROM with
an overmounted /etc/mtab...

Is anyone working on such a translucent file system? 
