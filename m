Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbUDNMhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbUDNMhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:37:39 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:64777 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264147AbUDNMhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:37:32 -0400
Message-ID: <407D30C6.3040009@aitel.hist.no>
Date: Wed, 14 Apr 2004 14:38:30 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
References: <20040412221717.782a4b97.akpm@osdl.org>	<407B9FB1.8070107@aitel.hist.no> <20040413011133.2d15a4d6.akpm@osdl.org>
In-Reply-To: <20040413011133.2d15a4d6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
>>I tried stepping up from 2.6.5-rc3-mm4 to 2.6.5-mm4.
>>This Quokka seems too zonked to work though.
>>
>>It came up, but I couldn't run "xterm".  Trying from
>>the xemacs shell I saw an error message about not enough ptys.
>>I use the devpts fs mounted on /dev/pts
>>
>>It mounts just fine, but doesn't work apparently.  There are no
>>such problems with 2.6.5-rc3-mm4
> 
> 
> Is this 2.6.5-mm4 or 2.6.5-mm5?
> 
> If the latter, try reverting pty-allocation-first-fit.patch

Oops, it was 2.6.5-mm5, sorry.  I'm compiling
2.6.5-mm5-1 now

Helge Hafting

