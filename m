Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262407AbSJBBHf>; Tue, 1 Oct 2002 21:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262883AbSJBBHf>; Tue, 1 Oct 2002 21:07:35 -0400
Received: from calc.cheney.cx ([207.70.165.48]:55005 "EHLO calc.cheney.cx")
	by vger.kernel.org with ESMTP id <S262407AbSJBBHe>;
	Tue, 1 Oct 2002 21:07:34 -0400
Date: Tue, 1 Oct 2002 20:13:00 -0500
From: Chris Cheney <ccheney@cheney.cx>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 "Sleeping function called from illegal context at
Message-ID: <20021002011300.GB12613@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debug: sleeping function called from illegal context at semaphore.h:119

I don't have a serial console but if needed I can try copying all the
hex output after the debug message if needed.

Chris Cheney
