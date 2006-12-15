Return-Path: <linux-kernel-owner+w=401wt.eu-S1752771AbWLOPz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbWLOPz0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbWLOPz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:55:26 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:19267 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbWLOPzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:55:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SsVSeKNuNl9k0Be/BksTJKm1V3b+dp9kQ10YFDQuwJbJi4J30CpWD9d7FefeLOT7IfMYb9AL3fuzob8v29B1quH+HjJnxULPBdWNC4IWWM1pVnbrIHWQ4eGkTw8+tGzMDczwtrXm8We+ptflIQKIT4F9RHx0BxLhzGnPfQutJi4=
Message-ID: <4582C55C.9040507@gmail.com>
Date: Fri, 15 Dec 2006 16:54:45 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andreas Jaggi <andreas.jaggi@waterwave.ch>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] remove ambiguous redefinition of INIT_WORK
References: <20061215164946.433210e3@localhost>
In-Reply-To: <20061215164946.433210e3@localhost>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jaggi wrote:
> Removes an unused and ambiguous redefinition of INIT_WORK()
> 
> Signed-off-by: Andreas Jaggi <andreas.jaggi@waterwave.ch>
Acked-by: Jiri Slaby <jirislaby@gmail.com>

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
