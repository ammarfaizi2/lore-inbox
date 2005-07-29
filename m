Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbVG2Vkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbVG2Vkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVG2Vkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:40:33 -0400
Received: from opersys.com ([64.40.108.71]:18698 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262841AbVG2Vis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:38:48 -0400
Message-ID: <42EAA05F.4000704@opersys.com>
Date: Fri, 29 Jul 2005 17:32:15 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Average instruction length in x86-built kernel?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm wondering if anyone's ever done an analysis on the average length
of instructions in an x86-built kernel.

Googling around, I can find references claiming that the average
instruction length on x86 is anywhere from 2.7 to 3.5 bytes, but I
can't find anything studying Linux specifically.

Just curious,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
