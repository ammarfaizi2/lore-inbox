Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTIOOTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbTIOOTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:19:38 -0400
Received: from luli.rootdir.de ([213.133.108.222]:4482 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261403AbTIOOTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:19:37 -0400
Date: Mon, 15 Sep 2003 16:19:33 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm2
Message-ID: <20030915141933.GA1246@rootdir.de>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
Reply-By: Thu Sep 18 16:18:38 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm2 i686
X-No-archive: yes
X-Uptime: 16:18:38 up 10 min,  1 user,  load average: 0.09, 0.51, 0.35
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there is an error, after make modules_install
/lib/modules/2.6.0-test5-mm2/build points to ".",
but it should point to /usr/src/linux-2.6.0-test5-mm5/

bye, claas
