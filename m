Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVCKTvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVCKTvn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCKTuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:50:21 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:35183 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261755AbVCKTe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:34:28 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org
Subject: Re: [patch 1/2] uml: export getgid for hostfs
Date: Fri, 11 Mar 2005 20:33:47 +0100
User-Agent: KMail/1.7.2
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20050311192945.DEB396477@zion>
In-Reply-To: <20050311192945.DEB396477@zion>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112033.47486.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 20:29, blaisorblade@yahoo.it wrote:
> Export this symbol which is now needed for a typo fix (getuid() ->
> getgid()).
Sorry for resending, I sent it wrong twice.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

