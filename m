Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSJQA7f>; Wed, 16 Oct 2002 20:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbSJQA7f>; Wed, 16 Oct 2002 20:59:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48566 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261601AbSJQA7e>;
	Wed, 16 Oct 2002 20:59:34 -0400
Date: Wed, 16 Oct 2002 17:58:09 -0700 (PDT)
Message-Id: <20021016.175809.28811497.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: make arp seq_file show method only produce one
 record per call
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017010135.GR7541@conectiva.com.br>
References: <20021017010135.GR7541@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Wed, 16 Oct 2002 22:01:36 -0300

   	Please pull from:
   
   master.kernel.org:/home/acme/BK/net-2.5
   
Pulled, thanks.

Now to help Al create a sane mechanism for carrying private state
around between start/stop :-)

