Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVJEQ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVJEQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVJEQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:28:56 -0400
Received: from amdext4.amd.com ([163.181.251.6]:16859 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030222AbVJEQ2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:28:55 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Wed, 5 Oct 2005 10:46:26 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 0/5] AMD Geode GX/LX support V2
Message-ID: <20051005164626.GA25189@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5D20C92RW1845573-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to everybody for their constructive comments on my previous 
patch posting.  I ended up eliminating one patch, and combining two
of the others, so we're down to 5 from the original 7.  

Patches 1 and 2 from before have been combined into 1 patch, and patch
4 (IDE) has been removed all together in lieu of a better patch floating
around on the linux-ide list.

Al patches following have individual changelogs attached. 
Thanks again for your comments - keep 'em coming.

Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

