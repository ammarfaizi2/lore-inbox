Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262681AbVCWPSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVCWPSw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCWPSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:18:52 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:54790 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S262683AbVCWPSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:18:49 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050323145204.GA23661@roonstrasse.net>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050323135317.GA22959@roonstrasse.net> <1111587814.27969.86.camel@nc>
	 <20050323142753.GA23454@roonstrasse.net> <1111589098.27969.100.camel@nc>
	 <20050323145204.GA23661@roonstrasse.net>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 16:18:47 +0100
Message-Id: <1111591127.27969.121.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 15:52 +0100, Max Kellermann wrote:

> You see, RLIMIT_CPU is worthless in its current implementation.

You are right. Limiting CPU is probably not a good solution anyway.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105808941823955&w=2

--
Natanael Copa


