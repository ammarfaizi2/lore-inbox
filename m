Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279725AbRJYIGt>; Thu, 25 Oct 2001 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279724AbRJYIGj>; Thu, 25 Oct 2001 04:06:39 -0400
Received: from fm3.freemail.hu ([194.38.105.13]:45060 "HELO fm3.freemail.hu")
	by vger.kernel.org with SMTP id <S279723AbRJYIG0>;
	Thu, 25 Oct 2001 04:06:26 -0400
Date: Thu, 25 Oct 2001 10:06:55 +0200 (CEST)
From: Marton Kadar <marton.kadar@freemail.hu>
Subject: concurrent VM subsystems
To: linux-kernel@vger.kernel.org
Message-ID: <freemail.20010925100655.37794@fm3.freemail.hu>
X-Originating-IP: [195.212.231.162]
X-HTTP-User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an idea from an absolute layman who keeps
an eye on Kernel Traffic:

Isn't it possible to include both VM approaches in the
kernel sources? It would be nice to be able to choose
at compile time through a configuration option.
Perhaps Andrea Arcangeli's version could be marked 
experimental.


