Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269837AbUJVI6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269837AbUJVI6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 04:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270857AbUJVI6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 04:58:23 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:1544 "EHLO xiii.metz")
	by vger.kernel.org with ESMTP id S269837AbUJVI6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 04:58:12 -0400
Message-ID: <4178CB95.7000505@linbox.com>
Date: Fri, 22 Oct 2004 10:57:57 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jsimmons@infradead.org, geert@linux-m68k.org
Subject: 2.6.9 bug: linux logo not displayed in vga16fb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I used to have a nice vga boot logo with my 2.6.7 kernel, but with the 2.6.9, my
boot logo has disappeared (same .config)...
It seems to switch to VGA, and some space is reserved for the logo, but it is 
not displayed.
The logo appears with vesafb.


Any idea / patch welcome !

Cheers,

   Ludo

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 50 87 90                            fax : 03 87 75 19 26
