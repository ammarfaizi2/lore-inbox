Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314098AbSDQOqz>; Wed, 17 Apr 2002 10:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314099AbSDQOqy>; Wed, 17 Apr 2002 10:46:54 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:34689 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314098AbSDQOqq>; Wed, 17 Apr 2002 10:46:46 -0400
Subject: Re: Callbacks to userspace from VFS ?
From: Martin Rode <martin.rode@programmfabrik.de>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15549.34936.502136.339319@laputa.namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 16:40:27 +0200
Message-Id: <1019054427.8745.114.camel@marge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

I did not look deeper into F_NOTIFY, but if I only get a SIGNAL I don't
know _what_ has happened (or better on what file something has
happened). But to process the new / updated files I need the filename.
If I only learn which directory was updated I still have to find out
_which_ file is new or was changed.

Regards,

;Martin

-- 
                  Dipl.-Kfm. Martin Rode                    
                     Managing Director

                martin.rode@programmfabrik.de                  

Programmfabrik GmbH                 Fon +49-(0)30-4281-8001
Frankfurter Allee 73d               Fax +49-(0)30-4281-8008
10247 Berlin                        Funk +49-(0)163-5321400
 
                http://www.programmfabrik.de/
 




