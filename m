Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264800AbRFSVp5>; Tue, 19 Jun 2001 17:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264801AbRFSVps>; Tue, 19 Jun 2001 17:45:48 -0400
Received: from zeke.inet.com ([199.171.211.198]:56472 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S264800AbRFSVpj>;
	Tue, 19 Jun 2001 17:45:39 -0400
Message-ID: <3B2FC7F4.2AAA6A8D@inet.com>
Date: Tue, 19 Jun 2001 16:45:24 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gabriel Rocha <grocha@onesecure.com>
CC: "McHarry John" <john.mcharry@gemplex.com>, linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com> <20010619143253.F81548@onesecure.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Rocha wrote:
> 
> you could always compile on one machine and nfs mount the /usr/src/linux
> and do a make modules_install from the nfs mounted directory...

Which would require exporting that filesystem with root permissions
enabled...any security bells going off?

C-ya,

Eli 
-----------------------.   No wonder we didn't get this right first time
Eli Carter             |      through. It's not really all that horribly 
eli.carter(at)inet.com `- complicated, but the _details_ kill you. Linus
