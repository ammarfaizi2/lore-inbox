Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTIIGOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 02:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTIIGOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 02:14:47 -0400
Received: from main.gmane.org ([80.91.224.249]:10122 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262050AbTIIGOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 02:14:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: [NBD] patch and documentation
Date: Tue, 09 Sep 2003 08:10:26 +0200
Message-ID: <bjjr4k$30a$1@sea.gmane.org>
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en
In-Reply-To: <3F5CF045.DDDE475C@SteelEye.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> echo "126" > /proc/sys/vm/max-readahead
> I think that should help out.

Well, it didn't help. Still the same funny pattern of 127 and 1KB 
requests ;-)


