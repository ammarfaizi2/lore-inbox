Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291965AbSBAUEb>; Fri, 1 Feb 2002 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291966AbSBAUEV>; Fri, 1 Feb 2002 15:04:21 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:29769 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S291965AbSBAUEI>; Fri, 1 Feb 2002 15:04:08 -0500
Date: Fri, 1 Feb 2002 21:09:43 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.3] error seeking in /dev/kmem
Message-ID: <20020201200943.GA1128@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0-hc8-current-20020125i (Linux 2.5.3-K0 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After installing 2.5.3 I get the following in /var/log/warn:

      [....]
      Feb  1 21:01:32 elfie kernel: Error seeking in /dev/kmem
      Feb  1 21:01:32 elfie kernel: Symbol #serial, value d0811000
      Feb  1 21:01:32 elfie kernel: Error adding kernel module table entry.
      [....]
   
What can I do to avoid this, what's the cause?
			       
-- 
# Heinz Diehl, 68259 Mannheim, Germany
