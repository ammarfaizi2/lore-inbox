Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263601AbUDUSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbUDUSop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbUDUSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:44:45 -0400
Received: from smtp-107-backup.noc.nerim.net ([62.4.17.107]:18953 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263601AbUDUSoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:44:44 -0400
Date: Wed, 21 Apr 2004 20:45:07 +0200
From: Jean Delvare <khali@linux-fr.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Permissions on include/video/neomagic.h
Message-Id: <20040421204507.2dee599b.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.44.0404211810070.8561-100000@phoenix.infradead.org>
References: <20040418202223.6b226e19.khali@linux-fr.org>
	<Pine.LNX.4.44.0404211810070.8561-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640.
> > It obviously should be 0644.
>
> I'm preparing new neofb patch for Andrew Morton. They will fix this.

Just curious... How can a patch change file permissions?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
