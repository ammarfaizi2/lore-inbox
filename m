Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267711AbUIBHIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUIBHIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIBHIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:08:23 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:34222
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267711AbUIBHIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:08:19 -0400
Message-ID: <4136C6E1.4090404@bio.ifi.lmu.de>
Date: Thu, 02 Sep 2004 09:08:17 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Identify security-related patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there an easy way to identify all security-related patches out of the
mass of patches floating around  on linux.bkbits.net or the kernel bugzilla?

I'm running 2.6.8.1 and would like to keep it as stable as possible, thus,
only apply security patches. Currently I'm searching for "security" and
alike on bitkeeper, but there seems to be no consistent marking.

For instance, it would be nice if all security fixes contained a consistent
marker like "[SECURITY]" in the changeset comments (like the reiserfs xattr/acl
patch does), so that it would be easy to identify them. Or setting some kind
of flag to such patches (I've no idea what bitkeeper allows one to do...).

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

