Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbUKVRe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbUKVRe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUKVR2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:28:24 -0500
Received: from neopsis.com ([213.239.204.14]:39051 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262251AbUKVRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:15:10 -0500
Message-ID: <41A21EAA.2090603@dbservice.com>
Date: Mon, 22 Nov 2004 18:15:22 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
Cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com> <41A1FFFC.70507@hist.no>
In-Reply-To: <41A1FFFC.70507@hist.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I recommend looking at archived threads about file as directory,
> you'll find many more arguments.  Currently there is one kind
> of support for archive files - loop mounts over files containing
> filesystem images.  These are not compressed though.

Isn't reiserfs trying to implement such things? I've read that in some 
next version of reiserfs one will be able to open /etc/passwd/[username] 
  and get the informations about [username], like UID, GID, home 
directory etc.

Still true? And when can we except such a version of reiserfs?

tom
