Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136300AbRDVWPn>; Sun, 22 Apr 2001 18:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136302AbRDVWPd>; Sun, 22 Apr 2001 18:15:33 -0400
Received: from [195.180.174.209] ([195.180.174.209]:24962 "EHLO
	idun.neukum.org") by vger.kernel.org with ESMTP id <S136300AbRDVWPZ>;
	Sun, 22 Apr 2001 18:15:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: question on atomic_t
Date: Mon, 23 Apr 2001 00:15:15 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042300151501.03169@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

can I assume that a member of a structure of type atomic_t is 0 after using 
memset to zero on the structure ?

	TIA
		Oliver
