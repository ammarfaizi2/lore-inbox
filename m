Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290033AbSAWUUo>; Wed, 23 Jan 2002 15:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290045AbSAWUUa>; Wed, 23 Jan 2002 15:20:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58752 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290033AbSAWUUN>;
	Wed, 23 Jan 2002 15:20:13 -0500
Date: Wed, 23 Jan 2002 12:18:57 -0800 (PST)
Message-Id: <20020123.121857.18310310.davem@redhat.com>
To: riel@conectiva.com.br
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM, version 12
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0201231735540.32617-100000@imladris.surriel.com>
In-Reply-To: <20020123.112837.112624842.davem@redhat.com>
	<Pine.LNX.4.33L.0201231735540.32617-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Wed, 23 Jan 2002 17:36:35 -0200 (BRST)
   
   OK, so only the _pgd_ quicklist is questionable and the
   _pte_ quicklist is fine ?

That is my understanding.
