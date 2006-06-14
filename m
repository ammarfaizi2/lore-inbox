Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWFNNpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWFNNpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWFNNpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:45:44 -0400
Received: from smtp103.plus.mail.re2.yahoo.com ([206.190.53.28]:54371 "HELO
	smtp103.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964923AbWFNNpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:45:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Received:Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:User-Agent;
  b=z1DjI4X3MP5l3qhV8eVQ4lxroIFkCR2SExzgkLxvSpbzegDV6YXW8DJWaZaNZbb1BunE1nXoucuAjJhoD7yYaEzUtfkxXuFUIC+P7ReaBSnqDLofhcj2EXJpBp74La1zGL2O1YWqCVEjnOZsn/DV6zt4omtMryHDpoKUyU8q1Ik=  ;
Date: Wed, 14 Jun 2006 14:45:37 +0100
From: Pablo Barbachano <pablobarbachano@yahoo.es>
To: linux-kernel@vger.kernel.org
Subject: loop devices removable
Message-ID: <20060614134537.GA12541@laptop-271718>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I would like to know where do I need to look to make the loop
devices removable. The effect I want is to make
/sys/block/loop*/removable have a value of 1.

I have been grepping for a while in the kernel sources but found
nothing.

The (probably broken) reason I want to do that is so I can use (my
modified) pmount to mount them.

(And now I run behind a rock before someone tells me how broken is
that)

Cheers,
Pablo

-- 
"When in doubt, use brute force" -- Ken Thompson

		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com
