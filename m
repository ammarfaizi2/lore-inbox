Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTLVKUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTLVKUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:20:21 -0500
Received: from main.gmane.org ([80.91.224.249]:33466 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264368AbTLVKUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:20:19 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <marc.bevand@smartjog.com>
Subject: Re: Oops with 2.4.23
Date: Mon, 22 Dec 2003 11:07:20 +0100
Message-ID: <bs6fvk$2l6$1@sea.gmane.org>
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl> <20031219235521.GK6438@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031118
X-Accept-Language: en-us, en
In-Reply-To: <20031219235521.GK6438@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Has anyone noticed if several runs with the normal tests, or a single test
> with all tests running catches more errors?

Yes, I have already encountered such a situation. The box was an
Athlon 600 with 512 MB of SDRAM (partly defectuous). Running the
"normal tests" multiple times hasn't showed any error, but running
"all tests" one time has detected some errors (IIRC it has taken more
than 12 hours).

-- 
Marc Bevand


