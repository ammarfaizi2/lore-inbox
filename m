Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRJYNNn>; Thu, 25 Oct 2001 09:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRJYNNd>; Thu, 25 Oct 2001 09:13:33 -0400
Received: from ns.ithnet.com ([217.64.64.10]:41737 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273565AbRJYNNT>;
	Thu, 25 Oct 2001 09:13:19 -0400
Date: Thu, 25 Oct 2001 15:13:43 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Max number of open files in 2.4.x
Message-Id: <20011025151343.21b3daef.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Do I really have to patch source and recompile a 2.4 kernel to modify the
maximum number of open files?

Why is there such a hardcoded limit anyway?

Regards,
Stephan
