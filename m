Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVLGDWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVLGDWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbVLGDWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:22:37 -0500
Received: from web32403.mail.mud.yahoo.com ([68.142.207.196]:12955 "HELO
	web32403.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750926AbVLGDWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:22:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fas71O54ZxpXpcA9kKiqDeBjrPvfmfB+GqazxF03rG8oAEnsS+zy5W3kXHnuuZxS+n2w8ex4Z+zFxgJoP7ok0fzjOgHD1cQMOF+3rT4jWzWIRVUOAv05Hf4B/wE+VFEpsHLqi+yV2kDcVAcjH9GDxz67m244/3nxrhbAHkoM0yE=  ;
Message-ID: <20051207032236.71308.qmail@web32403.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 19:22:36 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: Physical to Page in 2.6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

How to get a page from a physical address for a x86_64
in 2.6 kernel.
I guess there are macros in 2.4 like phys_to_pfn( )
and pfn_to_page(). I don't see these macros in 2.6 for
x86_64 arch.

These macros are defined only if CONFIG_DISCONTIGMEM
for 2.6. 

regards,
 Anil


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

